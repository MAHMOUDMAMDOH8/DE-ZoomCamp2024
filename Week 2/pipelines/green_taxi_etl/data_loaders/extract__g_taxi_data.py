import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    urls = ['https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-10.csv.gz',
            'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-11.csv.gz',
            'https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2020-12.csv.gz'
    ]
    Taxi_Dtype = {
                    'VendorID':pd.Int64Dtype(),
                    'passenger_count':pd.Int64Dtype(),
                    'trip_distance':float,
                    'RatecodeID':pd.Int64Dtype(),
                    'store_and_fwd_flag':str,
                    'PULocationID':pd.Int64Dtype(),
                    'DOLocationID':pd.Int64Dtype(),
                    'payment_type':pd.Int64Dtype(),
                    'fare_amount':float,
                    'extra':float,
                    'mta_tax':float,
                    'tip_amount':float,
                    'tolls_amount':float,
                    'improvement_surcharge':float,
                    'total_amount':float,
                    'congestion_surcharge':float
    }

    Data = []

    for U in urls :
        response = requests.get(U)
        if response.status_code == 200:
            df = pd.read_csv(io.BytesIO(response.content), compression='gzip', dtype=Taxi_Dtype)
            Data.append(df)
        else:
            print(f'Failed to fetch data from {U}')
    if Data:
        return pd.concat(Data, ignore_index=True)
    else:
        return None
        
    



@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
