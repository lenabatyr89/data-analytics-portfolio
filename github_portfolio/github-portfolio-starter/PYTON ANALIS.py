# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

import pandas as pd


df = pd.read_csv('bugs_final.csv', parse_dates=['created_at', 'closed_at'])


if 'resolution_time_days' not in df.columns:
    df['resolution_time_days'] = (df['closed_at'] - df['created_at']).dt.days


long_bugs = df[df['resolution_time_days'] > 180]
short_bugs = df[df['resolution_time_days'] <= 180]


long_bugs.to_csv('long_bugs.csv', index=False)
short_bugs.to_csv('short_bugs.csv', index=False)


print("⏱ זמן טיפול ממוצע בכל הדאטה:", round(df['resolution_time_days'].mean(), 2), "ימים")
print("⏱ זמן טיפול באגים קצרים:", round(short_bugs['resolution_time_days'].mean(), 2), "ימים")
print("⏱ זמן טיפול באגים ארוכים:", round(long_bugs['resolution_time_days'].mean(), 2), "ימים")


df = pd.read_csv("long_bugs.csv")


print("סה״כ באגים ארוכים:", len(df))


print("\n🔧 קומפוננטות נפוצות:")
print(df['component'].value_counts().head(10))


print("\n⚠️ עדיפויות נפוצות:")
print(df['priority'].value_counts().head(10))

print("\n💻 מערכות הפעלה נפוצות:")
print(df['operating_system'].value_counts().head(10))


