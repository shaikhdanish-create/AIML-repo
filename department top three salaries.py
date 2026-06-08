import pandas as pd

# Employee table
employee = pd.DataFrame({
    'id': [1, 2, 3, 4, 5, 6, 7],
    'name': ['John', 'Alice', 'Bob', 'David', 'Emma', 'Tom', 'Sara'],
    'salary': [90000, 85000, 80000, 95000, 90000, 87000, 82000],
    'departmentId': [1, 1, 1, 2, 2, 2, 2]
})

# Department table
department = pd.DataFrame({
    'id': [1, 2],
    'name': ['IT', 'HR']
})

def top_three_salaries(employee: pd.DataFrame,
                       department: pd.DataFrame) -> pd.DataFrame:

    employee['rnk'] = (
        employee.groupby('departmentId')['salary']
        .rank(method='dense', ascending=False)
    )

    return (
        employee.loc[employee.rnk <= 3]
        .merge(department, left_on='departmentId', right_on='id')
        .rename(columns={'name_y': 'Department',
                         'name_x': 'Employee',
                         'salary': 'Salary'})
        [['Department', 'Employee', 'Salary']]
    )

# Call function
result = top_three_salaries(employee, department)

print(result)
