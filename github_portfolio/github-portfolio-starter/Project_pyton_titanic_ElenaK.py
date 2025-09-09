# -*- coding: utf-8 -*-
"""
Created on Sat Jun  7 12:38:39 2025

@author: batyr
"""

import seaborn as sb
import pandas as pd
sb.get_dataset_names()
df=sb.load_dataset('titanic')
import time


##Q1##
def passager_name():
    max_tries=3
    while True:
        for option in range(1,max_tries+1):
            name = input('Please enter name: ')
            print(name)
            if not name:
                print('The name cannot be empty.')
            elif len (name)<2:
               print('The name is too short.')
            elif any (char.isdigit()for char in name):
                   print('The name cannot contain numbers.')
            else:
                print(f' The name is valid:{name}')
                return name 
            print(f'(Try {option} from {max_tries})\n')
        else:
            print(' Too many faied tries. Please wait 10 seconds...')
            time.sleep(10)
            retry=input('Try again? (yes/no):')
            if retry!='yes':
                print ('Thank you, maybe see you latter')
                return None
            else:
                continue    

##Q2##      
def passager_age():
    max_number=2
    while True:
        for number in range(1,max_number+1):
            age=input('Please write you age:')
            print(age)
            if not age:
                print('Age cannot be empty.')
            elif not age.isdigit():
                print('Age must be a whole number without letters')
            else:
               age = int(age)
               if not (0 < age < 120):
                   print(' Age must be between 0 and 119.')
               else:
                   print(f'Age is valid: {age}')
                   return age

               print(f'(Try {number} of {max_number})\n')
        
        print(' Too many failed tries. Please wait 10 second...')
        time.sleep(10)
        retry=input('Try again? (yes/no):')
        if retry!='yes':
            print ('Thank you, maybe see you latter')
            return None
        else:
            continue

##Q3##
def passager_sex():
    max_tries=3
    while True:
        for option in range(1,max_tries+1):
            sex=input('Please enter your sex:')
            if sex in ['f', 'F', '0', 'Female', 'female', 'FEMALE']:
                return 'F'
            elif sex in ['m', 'M', '1', 'Male', 'male', 'MALE']:
                return 'M'
            else:
                print(f'Invalid input.\n(Try {option} from {max_tries})\n')
        print(' Too many failed tries. Please wait 10 seconds...')
        time.sleep(10)
        
        retry=input('Try again? (yes/no):')
        if retry!='yes':
            print ('Thank you, maybe see you latter')
            return None
        else:
            continue
       
        
##Q4##

titanic = sb.load_dataset('titanic')

def class_by_price():
    max_number=2
    while True:
        for number in range(1,max_number+1):
            price= input('Pleas enter the price of the ticke:')
            if not price:
                print('Price cannot be empty.')
            elif not price.isdigit():
                print('Price must be a whole number without letters')
            else:
                price = int(price)
                if price > 50:
                    return 'first class'
                elif 20 < price <= 50:
                    return 'second class'
                else:
                    return 'third class'
              

            print(f'(Try {number} of {max_number})\n')
        
        print('Too many failed tries. Please wait 10 seconds...\n')
        time.sleep(10)
        retry = input('Try again? (yes/no): ').strip().lower()
        if retry != 'yes':
            print('Thank you, maybe see you later.')
            return None
        else:
            continue


##Q5##
import random

existing_cards = set()
def generate_unique_card(existing_cards):
    numbers= '0123456789'
    while True:
        card =''. join(random.choice(numbers)for i in range(6))
        if card not in existing_cards:
            existing_cards.add(card)
            return card
card_number = generate_unique_card(existing_cards)



##Q7##
def calculate_risk(age, sex, travel_class):
    risk_score = 0

    # Age risk
    if age <= 3:
        risk_score += 2 
    elif 4 <= age <= 20:
        risk_score += 0
    elif 21 <= age <= 50:
        risk_score += 1
    else:  # age > 50
        risk_score += 2

    # Sex risk
    if sex == 'F':
        risk_score += 0
    else:
        risk_score += 1

    # Class risk
    if travel_class == 'first class':
        risk_score += 0
    elif travel_class == 'second class':
        risk_score += 1
    else: 
        risk_score += 2

    # Final risk check
    if risk_score <= 1:
        level = 'Very Low'
        message = 'Your survival risk is very low!'
    elif risk_score == 2:
        level = 'Medium'
        message = 'Your survival risk is medium!'
    else:
        level = 'High'
        message = 'Your survival risk is very high!'

    return level, message

##Q6##
def print_ticket():
    name = passager_name()
    age = passager_age()
    sex = passager_sex()
    pclass = class_by_price()
    card = generate_unique_card(existing_cards)
    
    risk_level, message = calculate_risk(age, sex, pclass)
    
    filename=f'{name}_ticet.txt'
    with open (filename, 'w+') as file:
        file.write('Titanic Boarding Pass\n')
        file.write(' \n')
        file.write(f'Name   : {name}\n')
        file.write(f'Age    : {age}\n')
        file.write(f'Sex    : {sex}\n')
        file.write(f'Class  : {pclass}\n')
        file.write(f'Card   : {card}\n')
        file.write(f"{message}\n")
        file.write(' \n')
    print(f'Ticket saved to: {filename}')
    with open(filename, 'r') as file:
        print(file.read())
             
print_ticket()




    




