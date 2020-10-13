from django.db import models
import json

# Create your models here.
class ExchangeRate(models.Model):
  country = models.CharField(max_length=50, null='false')
  currency = models.CharField(max_length=50, null='false')
  sellingPrice = models.FloatField(null='false')
  buyingPrice = models.FloatField(null='false')
  averagePrice = models.FloatField(null='false')
  lastUpdate = models.CharField(max_length=30)
  def __str__(self):
          return self.country
  def get_exchange_rate(self):
    return {
      "country": self.country,
      "currency": self.currency,
      "selling": round(self.sellingPrice,3),
      "buying": round(self.buyingPrice,3),
      "average": round(self.averagePrice,3),
      "updated": self.lastUpdate
    }
  def update_exchange_rate(self,lastUpdate, averagePrice):
    kBuy = 0.98
    kSell = 1.02
    try:
      self.lastUpdate = lastUpdate
      self.averagePrice = averagePrice
      self.buyingPrice = kBuy*averagePrice
      self.sellingPrice = kSell*averagePrice
    except Exception as e:
      print(e)

