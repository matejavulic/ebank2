# Generated by Django 2.2.4 on 2020-09-06 19:19

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='exchangeRate',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('country', models.CharField(max_length=50, null='false')),
                ('currency', models.CharField(max_length=50, null='false')),
                ('sellingPrice', models.FloatField(null='false')),
                ('buyingPrice', models.FloatField(null='false')),
                ('averagePrice', models.FloatField(null='false')),
                ('lastUpdate', models.CharField(max_length=30)),
            ],
        ),
    ]
