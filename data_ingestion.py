import polars as pl

documnetation_df = pl.read_csv(
    "data/Documentation.csv"
)

print(df.head())
