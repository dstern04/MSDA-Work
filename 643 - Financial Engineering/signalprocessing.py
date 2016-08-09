import numpy as np
import pandas as pd
import pytz


def initialize(context):
    context.stock = sid(24)
    context.prior_datetime = None
    # set short and long price windows
    context.long_window = 100
    context.short_window = 50
    context.day = None
    # set decay factor for EWMA
    context.decay_factor = 8

def handle_data(context,data):
    # trade once a day
    if get_datetime().day == context.day:  
        return  
    context.day = get_datetime().day   
    
    stock = context.stock
    # get short and long price history
    prices_long = data.history(stock, 'price', context.long_window, '1d')
    prices_short = data.history(stock, 'price', context.short_window, '1d')
    # calculate EWMA for each
    ew_long = pd.ewma(prices_long,context.decay_factor)
    ew_short = pd.ewma(prices_short,context.decay_factor)
    
    # get most recent estimate for each
    long_ewma = ew_long[-1]
    short_ewma = ew_short[-1]
    # if it is increasing in the short term, store and log
    increasing = short_ewma > long_ewma
    log.info("Buy Signal: " + str(increasing))
    current_price = data.current(stock,'price')
    record(price=current_price,short_ewma=short_ewma,long_ewma=long_ewma)
    # if increasing in the short term, buy
    if increasing and data.can_trade(stock):
       order_target_percent(stock, 1)
    # if decreasing in the shor term, sell
    elif not increasing and data.can_trade(stock):
       order_target_percent(stock, -1)
    # otherwise, zero out
    else:
       order_target_percent(stock, 0)
