from django.urls import path
from django.conf.urls import url
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    url(r'^eur/$', views.ExchangeRate.getEur), #.../exchangelist/eur
    url(r'^eurraw/$', views.ExchangeRate.getEurRaw), #.../exchangelist/eur
]
