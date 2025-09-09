# -*- coding: utf-8 -*-
"""
Created on Tue May 27 18:03:28 2025

@author: batyr
"""

import seaborn as sb
import pandas as pd
sb.get_dataset_names()
df=sb.load_dataset('diamonds')
print(df.columns)


##Q1##
x=df['price'].max()
print(f'The highest price of diamond is {x}')

##Q2##
y=df['price'].mean()
print(f'The average price of the diamonds is {y}')


##Q3##
z=df['cut'].value_counts()['Ideal']
print(f'The number of diamonds with cut Ideal is {z}')

##Q4##
num=df['color'].nunique()
colors=df['color'].unique()
print(f'We have {num} colors of diamond and the colors are :{', '.join(colors)}')

##Q5##
x=df[df['cut']=='Premium']['carat'].median()
print(f'The median carat of the Premium cat is {x}')

##Q6##
x=df.groupby('cut')['carat'].mean().to_frame()
x.rename(columns={'carat':'avg_carat'}, inplace=True)
x=x.reset_index()
print(x)


##Q7##
y=df.groupby('color')['price'].mean().to_frame()
y.rename(columns={'price':'avg_price'}, inplace=True)
y=y.reset_index()
print(y)


                