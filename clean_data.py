import pandas as pd

years = [2014, 2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023]
for year in years:
    df = pd.read_csv('data/original/pbp-%d.csv' % year)
    df["Formation"] = df["Formation"].str.title()
    df["PlayType"] = df["PlayType"].str.title()
    df[["Formation", "PlayType", "PassType", "RushDirection", "PenaltyType"]] = df[
        ["Formation", "PlayType", "PassType", "RushDirection", "PenaltyType"]
    ].apply(lambda x: x.str.title())
    df[["Formation", "PlayType", "PassType", "RushDirection", "PenaltyType"]] = df[
        ["Formation", "PlayType", "PassType", "RushDirection", "PenaltyType"]
    ].apply(lambda x: x.str.replace(" ", ""))
    df.fillna(value='null', inplace=True)  # Replace NaN values with 'null'
    df.to_csv('data/pbp-%s.csv' % year, index=False)
