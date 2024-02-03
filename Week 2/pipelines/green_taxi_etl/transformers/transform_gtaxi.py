import pandas as pd
if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

@transformer
def transform(data, *args, **kwargs):
    data = data[(data['passenger_count'] > 0) & (data['trip_distance'] > 0)]
    data['lpep_pickup_date'] = pd.to_datetime(data['lpep_pickup_datetime']).dt.date
    data.rename(columns={'VendorID': 'vendorid', 'passenger_count': 'passenger_count', 'trip_distance': 'trip_distance'}, inplace=True)
    
    return data

@test
def test_output(output, *args) -> None:
    assert 'vendorid' in output.columns, 'VendorID column is not renamed'
    assert 'passenger_count' in output.columns, 'passenger_count column is not present'
    assert 'trip_distance' in output.columns, 'trip_distance column is not present'
    assert (output['vendorid'].isin([1, 2])).all(), 'vendor_id has invalid values'
    assert (output['passenger_count'] > 0).all(), 'passenger_count contains non-positive values'
    assert (output['trip_distance'] > 0).all(), 'trip_distance contains non-positive values'
