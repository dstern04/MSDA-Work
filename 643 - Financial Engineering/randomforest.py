from sklearn.ensemble import RandomForestClassifier
from collections import deque
import numpy as np

def initialize(context):
    context.security = sid(6683) 
    context.window_length = 10 
    context.classifier = RandomForestClassifier() 
    
    context.recent_prices = deque(maxlen=context.window_length + 2)
    context.recent_value = deque(maxlen=context.window_length + 2) 
    context.X = deque(maxlen=500) 
    context.Y = deque(maxlen=500) 
    context.prediction = 0 
    
    set_slippage(slippage.VolumeShareSlippage(volume_limit=0.025, price_impact=0.1))
    set_commission(commission.PerShare(cost=0.0075, min_trade_cost=1))
                 
    
def handle_data(context, data):
    curr_price = data.current(context.security, 'price')
    # response:
    context.recent_prices.append(curr_price) 
    # predictors : 200 day price avg, 5 day price avg, 5 day st dev
    context.recent_value.append([curr_price,   
                                 data.history(context.security, 'price', 200, '1d').mean(),
                                 data.history(context.security, 'price', 5, '1d').mean(),
                                 np.std(data.history(context.security, 'price', 5, '1d'))])
    
    if len(context.recent_prices) == context.window_length + 2: 
        
        response = context.recent_prices
        predictors = np.array(context.recent_value).flatten()
        context.X.append(predictors[:-1]) 
        context.Y.append(response[-1]) 

        if len(context.Y) >= 60: 
            
            context.classifier.fit(context.X, context.Y) 
            # predict current price
            context.prediction = context.classifier.predict(predictors[1:])
            # calculate difference in current price and prediction
            error = curr_price - context.prediction
            # if the price exceeds the prediction by 50 cents, then buy, else hold nothing
            if error > 0.5:
                order_target_percent(context.security, 1)
            else: 
                order_target_percent(context.security, 0)

            record(prediction_error = error)
            