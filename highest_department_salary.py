import pandas as pd

def department_highest_salary(employee: pd.DataFrame, department: pd.DataFrame) -> pd.DataFrame:
    # Merge employee and department tables
    merged = employee.merge(
        department,
        left_on='departmentId',
        right_on='id',
        how='left'
    )

    # Find employees with highest salary in each department
    highest_salary = merged.loc[
        merged.groupby('departmentId')['salary'].transform('max')
        == merged['salary']
    ]

    # Select and rename columns
    result = highest_salary[['name_x', 'salary', 'name_y']].rename(
        columns={
            'name_y': 'Department',
            'name_x': 'Employee',
            'salary': 'Salary'
        }
    )

    return result[['Department', 'Employee', 'Salary']]


# Employee table
employee = pd.DataFrame({
    'id': [1, 2, 3, 4, 5],
    'name': ['Joe', 'Jim', 'Henry', 'Sam', 'Max'],
    'salary': [70000, 90000, 80000, 60000, 90000],
    'departmentId': [1, 1, 2, 2, 1]
})

# Department table
department = pd.DataFrame({
    'id': [1, 2],
    'name': ['IT', 'Sales']
})

# Call function
print(department_highest_salary(employee, department))
