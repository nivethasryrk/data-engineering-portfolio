import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import (
    accuracy_score,
    precision_score,
    recall_score,
    f1_score,
    classification_report
)
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.pipeline import Pipeline

# ============================================
# Example 1: Structured Data ML Classification
# ============================================

def structured_ml_example():
    data = {
        "age": [25, 35, 45, 20, 23, 40, 50, 29, 33, 41],
        "income": [50000, 80000, 120000, 20000, 30000, 90000, 140000, 45000, 67000, 99000],
        "transactions": [2, 5, 8, 1, 2, 6, 9, 3, 4, 7],
        "purchased": [0, 1, 1, 0, 0, 1, 1, 0, 1, 1]
    }

    df = pd.DataFrame(data)

    X = df[["age", "income", "transactions"]]
    y = df["purchased"]

    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.3, random_state=42
    )

    model = RandomForestClassifier(random_state=42)
    model.fit(X_train, y_train)

    y_pred = model.predict(X_test)

    print("=== Structured Data ML Example ===")
    print("Accuracy :", accuracy_score(y_test, y_pred))
    print("Precision:", precision_score(y_test, y_pred, zero_division=0))
    print("Recall   :", recall_score(y_test, y_pred, zero_division=0))
    print("F1 Score :", f1_score(y_test, y_pred, zero_division=0))
    print("\nClassification Report:")
    print(classification_report(y_test, y_pred, zero_division=0))


# ============================================
# Example 2: NLP Text Classification
# ============================================

def nlp_example():
    data = {
        "review": [
            "This product is excellent and works great",
            "Very bad experience and poor quality",
            "Amazing service and fast delivery",
            "Terrible support and broken item",
            "I love this product",
            "Worst purchase ever",
            "Happy with the quality and service",
            "The item is not good",
            "Fantastic experience overall",
            "Very disappointing and bad"
        ],
        "label": [1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
    }

    df = pd.DataFrame(data)

    X_train, X_test, y_train, y_test = train_test_split(
        df["review"], df["label"], test_size=0.3, random_state=42
    )

    pipeline = Pipeline([
        ("tfidf", TfidfVectorizer(stop_words="english")),
        ("model", LogisticRegression())
    ])

    pipeline.fit(X_train, y_train)
    y_pred = pipeline.predict(X_test)

    print("\n=== NLP Text Classification Example ===")
    print("Accuracy :", accuracy_score(y_test, y_pred))
    print("Precision:", precision_score(y_test, y_pred, zero_division=0))
    print("Recall   :", recall_score(y_test, y_pred, zero_division=0))
    print("F1 Score :", f1_score(y_test, y_pred, zero_division=0))
    print("\nClassification Report:")
    print(classification_report(y_test, y_pred, zero_division=0))


if __name__ == "__main__":
    structured_ml_example()
    nlp_example()
