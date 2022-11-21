from reaktoro import *

db = NasaDatabase("nasa-cea")

gases = GaseousPhase("CH4 O2 CO2 CO H2O H2")

system = ChemicalSystem(db, gases)

state = ChemicalState(system)
state.temperature(1000, "celsius")
state.pressure(100, "bar")
state.set("CH4", 1.0, "mol")
state.set("O2",  0.5, "mol")

print("=== INITIAL STATE ===")
print(state)

solver = EquilibriumSolver(system)
res = solver.solve(state)  # equilibrate the `state` object!

assert res.succeeded(), "Calculation did not succeed!"

print("=== FINAL STATE ===")
print(state)
