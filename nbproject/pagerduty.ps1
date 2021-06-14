def scan_for_issues(device_name, total_value_ok):
    
    filter_resource_002 = df["Resource"]=='002'
    metrics = ['BitsOut', 'ArpAvaililability', 'BitsOut']
    
    
    for metric in metrics:
        filter_resource_metric = df["Metric"]==metric
        for index, row in df.iterrows():
            if row['Resource'] == device_name and row['Metric'] == metric and row['total']==total_value_ok:
                df_tmp = df.where(filter_resource_002 & filter_resource_metric , axis=0)
                df_tmp.dropna(inplace=True)
                total=int(df_tmp['total'])
                if total != total_value_ok:
                    print("not good")
