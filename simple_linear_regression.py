"""
simple_linear_regression.py

A minimal end-to-end Machine Learning example using scikit-learn.
Predicts a student's exam score based on hours studied, using
Linear Regression.

Libraries used: numpy, pandas, matplotlib, scikit-learn
"""

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error, r2_score


def main():
    # 1. Create a small synthetic dataset
    np.random.seed(42)
    hours_studied = np.random.uniform(1, 10, 50)
    exam_score = 5 * hours_studied + np.random.normal(0, 5, 50) + 20

    df = pd.DataFrame({
        "hours_studied": hours_studied,
        "exam_score": exam_score
    })
    print("Sample of the dataset:")
    print(df.head())

    # 2. Split into features (X) and target (y)
    X = df[["hours_studied"]]
    y = df["exam_score"]

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42
    )

    # 3. Train the model
    model = LinearRegression()
    model.fit(X_train, y_train)

    # 4. Make predictions
    y_pred = model.predict(X_test)

    # 5. Evaluate the model
    mse = mean_squared_error(y_test, y_pred)
    r2 = r2_score(y_test, y_pred)

    print(f"\nModel coefficient (slope): {model.coef_[0]:.2f}")
    print(f"Model intercept: {model.intercept_:.2f}")
    print(f"Mean Squared Error: {mse:.2f}")
    print(f"R^2 Score: {r2:.2f}")

    # 6. Visualize the results
    plt.scatter(X_test, y_test, color="blue", label="Actual")
    plt.plot(X_test, y_pred, color="red", linewidth=2, label="Predicted")
    plt.xlabel("Hours Studied")
    plt.ylabel("Exam Score")
    plt.title("Simple Linear Regression: Hours Studied vs Exam Score")
    plt.legend()
    plt.tight_layout()
    plt.savefig("linear_regression_result.png")
    print("\nPlot saved as linear_regression_result.png")


if __name__ == "__main__":
    main()
