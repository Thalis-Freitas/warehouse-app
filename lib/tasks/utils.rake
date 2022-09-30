namespace :utils do
  desc "Popular a tabela warehouses"
  if Rails.env.development?
    task set_warehouse: :environment do
      Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                        address: 'Avenida do Aeroporto, 1000', zip_code: '15000-000',
                        description: 'Galpão destinado para cargas internacionais')
      Warehouse.create!(name: 'Armazém SSA', code: 'SSA', city: 'Salvador', area: '90000',
                        address: 'Avenida do Aeroporto, 200', zip_code: '32100-000',
                        description: 'Galpão destinado para estoque de cargas')
    end
  else
    puts 'Ops, você não está no ambiente de desenvolvimento'
  end
end
