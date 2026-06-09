import pandas as pd

def combine_two_tables(person: pd.DataFrame, address: pd.DataFrame) -> pd.DataFrame:
    result = pd.merge(person, address, on='personId', how='left')
    result = result[['firstName', 'lastName', 'city', 'state']]
    return result

# Sample Person Table
person = pd.DataFrame({
    'personId': [1, 2, 3, 4],
    'firstName': ['Amit', 'Rahul', 'Priya', 'Sneha'],
    'lastName': ['Sharma', 'Patil', 'Singh', 'Khan']
})

# Sample Address Table
address = pd.DataFrame({
    'personId': [1, 2, 4],
    'city': ['Mumbai', 'Pune', 'Nashik'],
    'state': ['Maharashtra', 'Maharashtra', 'Maharashtra']
})

# Call Function
result = combine_two_tables(person, address)

print("Person Table:")
print(person)

print("\nAddress Table:")
print(address)

print("\nResult:")
print(result)
