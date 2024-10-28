# frozen_string_literal: true

Carrier.create(name: 'Default Carrier')

Route.create([{ origin: 'Berlin', destination: 'Warsaw' },
              { origin: 'Belfast', destination: 'Cardiff' },
              { origin: 'Prague', destination: 'Brussels' },
              { origin: 'Amsterdam', destination: 'Cologne' }])

LoadType.create([{ name: '5 pallets' }, { name: '10 pallets' }, { name: '26 pallets' }])
