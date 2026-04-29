import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgresql+psycopg2://postgres:postgres@localhost:5432/bank")

df = pd.read_excel("dataset/bank_dataset.xlsx", sheet_name="Fact_Operating_Expenses")
df.columns = [col.lower() for col in df.columns]
# df = df.rename(columns={
#     'month name': 'month_name',
#     'week of the year': 'week_of_year',
#     'is weekend': 'is_weekend',
# })
print(df.dtypes)

df.to_sql("fact_expenses", engine, if_exists="replace", index=False)