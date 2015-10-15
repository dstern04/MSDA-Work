class CarEvaluation:
	
	carCount = 0

        def __init__(self,brand,price,safety_rating):
            self.brand = brand
            self.price = price
            self.safety_rating = safety_rating
            self.price_numerical = 0
            CarEvaluation.carCount += 1
            
            # convert to numerical ranking to later sort by price
            
            if self.price == "Low":
                self.price_numerical = 1
            elif self.price == "Med":
                self.price_numerical = 2
            elif self.price == "High":
                self.price_numerical = 3
                
        def __repr__(self):
            return self.brand

        def showEvaluation(self):
            print "The", self.brand, "has a", self.price, "price and it's safety is rated a", self.safety_rating, "."
	

def sortbyprice(list,direction):
    if direction == "asc":
       list = sorted(list, key=lambda CarEvaluation: CarEvaluation.price_numerical)
    else:
        list = sorted(list, key=lambda CarEvaluation: CarEvaluation.price_numerical,reverse=True)
    return list
      
      

def searchforsafety(list,rating):
    for row in list:
        if row.safety_rating == rating:
            return True
        else:
            return False
	
# This is the main of the program.  Expected outputs are in comments after the function calls.
if __name__ == "__main__":	
   eval1 = CarEvaluation("Ford", "High", 2)
   eval2 = CarEvaluation("GMC", "Med", 4)
   eval3 = CarEvaluation("Toyota", "Low", 3)

   print "Car Count = %d" % CarEvaluation.carCount # Car Count = 3

   eval1.showEvaluation() #The Ford has a High price and it's safety is rated a 2
   eval2.showEvaluation() #The GMC has a Med price and it's safety is rated a 4
   eval3.showEvaluation() #The Toyota has a Low price and it's safety is rated a 3

   L = [eval1, eval2, eval3]

   print sortbyprice(L, "asc"); #[Toyota, GMC, Ford]
   print sortbyprice(L, "des"); #[Ford, GMC, Toyota]
   print searchforsafety(L, 2); #true
   print searchforsafety(L, 1); #false