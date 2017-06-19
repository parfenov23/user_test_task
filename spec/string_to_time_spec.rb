require 'rails_helper'

describe StringToTime do
  it 'when time is empty' do # Если вызываем метод и передаем в него nil то должно отдавать ошибку
    expect { StringToTime.sec(nil) }.to raise_error(NoMethodError)
  end

  it 'when call all params' do # Если вызываем метод и передаем все параметры
    expect( StringToTime.sec("1 year 5 months 12 days 1 hour 27 minutes 34 seconds") ).to eq 45559654
  end

  it 'when call portion params' do # Если вызываем метод и передаем только часть параметров
    expect( StringToTime.sec("1 year 5 months 27 minutes 34 seconds") ).to eq 44519254
  end

  it 'when call mix params' do # Если вызываем метод и передаем перемешанные параметры
    expect( StringToTime.sec("27 minutes 1 year 34 seconds 5 months") ).to eq 44519254
  end
end
