import pandas as pd

#Problem 1
df = pd.read_csv('2019_kbo_for_kaggle_v2.csv')

for year in range(2015, 2019):
    df_year = df[df['year'] == year]
    top_hits = df_year.nlargest(10, 'H')
    print(f'Top 10 H of {year}:')
    print(top_hits[['batter_name', 'H']])
    top_avg = df_year.nlargest(10, 'avg')
    print(f'Top 10 avg of {year}:')
    print(top_avg[['batter_name', 'avg']])
    top_hr = df_year.nlargest(10, 'HR')
    print(f'Top 10 HR of {year}:')
    print(top_hr[['batter_name', 'HR']])
    top_obp = df_year.nlargest(10, 'OBP')
    print(f'Top 10 OBP of {year}:')
    print(top_obp[['batter_name', 'OBP']])
    print("\n----------------------------------------\n")

#Problem 2
df_2018 = df[df['year'] == 2018]
top_war_by_position = df_2018.loc[df_2018.groupby('cp')['war'].idxmax()]
print('Player with highest war of 2018 by position:')
print(top_war_by_position[['cp', 'batter_name', 'war']])
print("\n----------------------------------------\n")

#Problem 3
df = pd.read_csv('2019_kbo_for_kaggle_v2.csv')
features = ['R', 'H', 'HR', 'RBI', 'SB', 'war', 'avg', 'OBP', 'SLG']
correlations = df[features + ['salary']].corr()['salary'].drop('salary')
highest_corr_feature = correlations.idxmax()
highest_corr_value = correlations.max()
print(f"'{highest_corr_feature}'has the highest correlation with salary, and the "
      f"coefficient is {highest_corr_value:.2f}.")
