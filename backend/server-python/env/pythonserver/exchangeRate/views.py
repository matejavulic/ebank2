#
# License: The MIT License (MIT)
# Author:E-bank IT team
# Author email: @ebanka-it.com
# Date: Fri Aug 23 2019
# Description:
# This Django module sends API call to an external service
# Upon receiving response data it pulls out only data for
# relation EUR/ USD, CHF, GBP, AUD and sends back as a JSON
#

import requests as req
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from django.views.generic import TemplateView
import json
from .models import ExchangeRate as er
from datetime import datetime

def index(request):
    return HttpResponse({"Success"})

class ExchangeRate(TemplateView):


  def getEur(self):

    def update(currentDate):

      #API address
      URL = "https://api.exchangeratesapi.io/latest"

      #list of currencies supported
      cur_l = ["CHF","EUR","USD","CAD","AUD","GBP","HRK","HKD","ISK"
         ,"PHP","DKK","HUF","CZK","RON","SEK","IDR","INR","BRL"
         ,"RUB","JPY","THB","MYR","BGN","TRY","CNY","NOK","NZD"
         ,"ZAR","MXN","SGD","ILS","KRW","PLN",]

      try:
        #parameter base
        currency = cur_l[1] #EUR
        PARAMS_currency = { "base":currency }
        r_json = req.get(url=URL, params=PARAMS_currency).json() #API response transform iton JSON
        rub = r_json["rates"]["RUB"] #pull out requested data
        cny = r_json["rates"]["CNY"]
        usd = r_json["rates"]["USD"]
        gbp = r_json["rates"]["GBP"]
        jpy = r_json["rates"]["JPY"]

        currenciesAvg = [rub, cny, usd, gbp, jpy]

        for avgI in range(1, len(currenciesAvg)+1):
          query = er.objects.get(id=avgI)
          query.update_exchange_rate(currentDate, currenciesAvg[avgI-1])
          query.save()
      except Exception as e:
        return {'message':str(e)}

    def checkUpdate(lastUpdate, currentDate):

      last = datetime.strptime(lastUpdate, "%Y-%m-%d %H:%M:%S")
      current = datetime.strptime(currentDate, "%Y-%m-%d %H:%M:%S")
      difference = current - last

      if (difference.total_seconds()/3600>24):
        update(currentDate)

    try:
      query = er.objects.all()
      rub = query[0].get_exchange_rate()
      cny = query[1].get_exchange_rate()
      usd = query[2].get_exchange_rate()
      gbp = query[3].get_exchange_rate()
      jpy = query[4].get_exchange_rate()

      lastUpdate = query[0].get_exchange_rate()['updated']
      currentDate = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
      checkUpdate(lastUpdate, currentDate)

      return JsonResponse({'source':'db','0':rub,'1':cny,'2':usd,'3':gbp,'4':jpy})

    except Exception as e:
     return JsonResponse({'message':'An error ocurred. Please try later.'})

  def getEurRaw(self):

      #API address
      URL = "https://api.exchangeratesapi.io/latest"

      #list of currencies supported
      cur_l = ["CHF","EUR","USD","CAD","AUD","GBP","HRK","HKD","ISK"
         ,"PHP","DKK","HUF","CZK","RON","SEK","IDR","INR","BRL"
         ,"RUB","JPY","THB","MYR","BGN","TRY","CNY","NOK","NZD"
         ,"ZAR","MXN","SGD","ILS","KRW","PLN",]

      try:
        #parameter base
        currency = cur_l[1] #EUR
        PARAMS_currency = { "base":currency }
        r_json = req.get(url=URL, params=PARAMS_currency).json() #API response transform iton JSON
        rub = r_json["rates"]["RUB"] #pull out requested data
        cny = r_json["rates"]["CNY"]
        usd = r_json["rates"]["USD"]
        gbp = r_json["rates"]["GBP"]
        jpy = r_json["rates"]["JPY"]
        return JsonResponse({'source':'api','0':rub,'1':cny,'2':usd,'3':gbp,'4':jpy}) #make JSON object again
      except Exception as e:
        return JsonResponse({'message':'An error ocurred. Please try later.'})
