'''
David Stern, Data 643, Mini-Project 1

This is a simple pairs trading algorithm, informed by the basic strategy outlined here:
http://gekkoquant.com/2013/01/21/statistical-arbitrage-trading-a-cointegrated-pair/

I used the Augmented Dicky-Fuller test to check for cointegration over the previous 30 days of trading
If the pair was cointegrated with a level of significance < 0.05, I initiated pairs trading. If the current spread 
exceeded the average spread by two standard deviations, I used half my portfolio to go long on the underperformer 
and the other half to short the overperformer. When the current spread returned tonormal, I exited the trade. 

'''

import statsmodels.tsa.stattools as ts
from scipy import stats

def initialize(context):
                      # Backtested from 1/1/10
    context.stocks = [[sid(698), sid(12691)],  
                      # Boeing & Lockheed: 1175% return, 1.88 alpha, 1.92 sharpe <- GOOD
                      [sid(3766), sid(1900)],  
                      # IBM & Cisco:  603% return, 0.92 alpha, 0.05 sharpe <- DECENT
                       [sid(3951), sid(351)]]  
                        # Intel & AMD: -1111%, -2.33 alpha, -0.21 sharpe <- BAD
    context.select_pair = 2
    context.lookback = 30
    context.adf_p_value = 0.05
    context.long_pos = False
    context.short_pos = False
    
def handle_data(context, data):  
    # assign each stock in the pair to variable:
    pair = context.stocks[context.select_pair]
    stockX = pair[0]
    stockY = pair[1]
    # get history for cointegration test:
    priceHistX = data.history(stockX, 'price', context.lookback, '1d')
    priceHistY = data.history(stockY, 'price', context.lookback, '1d')
    b, a, r, p, err = stats.linregress(priceHistX,priceHistY)
    spreadHist = priceHistY - (a + b * priceHistX)
    spread_sd = spreadHist.std()
    spread_mean = spreadHist.mean()
    # get current price and spread:
    priceX = data.current(stockX,'price')
    priceY = data.current(stockY,'price')
    current_spread = priceY - (a + b * priceX)
    # conditional: if cointegration test is signficant, then trade
    if ts.adfuller(spreadHist,1)[1] < context.adf_p_value:
        if current_spread >= spread_mean + 2*spread_sd and not context.long_pos:
            order_target_percent(stockX, 0.5)
            order_target_percent(stockY, -0.5)
            context.long_pos = True
            context.short_pos = False
            record("today's spread", current_spread)
            record("leverage", context.account.leverage)
        elif current_spread <= spread_mean + 2*spread_sd and not context.short_pos:
            order_target_percent(stockX, -0.5)
            order_target_percent(stockY, 0.5)
            context.long_pos = False
            context.short_pos = True
            record("today's spread", current_spread)
            record("leverage", context.account.leverage)
        # exit trade
        else:
            order_target_percent(stockX, 0)
            order_target_percent(stockY, 0)
            context.long_pos = context.short_pos = False
            record("today's spread", current_spread)
            record("leverage", context.account.leverage)

