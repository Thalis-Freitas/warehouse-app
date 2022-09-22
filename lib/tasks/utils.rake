namespace :utils do
  desc "Popular a tabela warehouses"
  if Rails.env.development? || Rails.env.test?
    task set_warehouse: :environment do
      Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
      address: 'Avenida do Aeroporto, 1000', cep: '15000-000',
      description: 'Galpão destinado para cargas internacionais')
    end
  else
    puts 'Ops, você não está no ambiente de desenvolvimento'
  end
end
