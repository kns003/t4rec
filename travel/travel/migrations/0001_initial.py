# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='TravelUser',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('user_id', models.CharField(max_length=50, null=True, blank=True)),
                ('name', models.CharField(max_length=100, null=True, blank=True)),
                ('access_token', models.CharField(max_length=2000, null=True, blank=True)),
                ('likes_result', models.CharField(max_length=9999, null=True, blank=True)),
                ('watson_data', models.TextField(null=True, blank=True)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
    ]
