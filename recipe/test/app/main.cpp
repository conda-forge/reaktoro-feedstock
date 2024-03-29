#include <Reaktoro/Reaktoro.hpp>
using namespace Reaktoro;

int main()
{
    SupcrtDatabase db("supcrt98");

    AqueousPhase aqueousphase("H2O(aq) H+ OH- HCO3- CO3-2 CO2(aq)");
    aqueousphase.setActivityModel(chain(
        ActivityModelHKF(),
        ActivityModelDrummond("CO2")
    ));

    GaseousPhase gaseousphase("CO2(g)");
    gaseousphase.setActivityModel(ActivityModelPengRobinson());

    ChemicalSystem system(db, aqueousphase, gaseousphase);
    ChemicalState state(system);
    state.temperature(25.0, "celsius");
    state.pressure(1.0, "bar");
    state.set("H2O(aq)", 1.0, "kg");
    state.set("CO2(g)", 10.0, "mol");

    EquilibriumSolver solver(system);
    auto res = solver.solve(state);

    errorif(res.failed(), "Calculation did not succeed!");

    std::cout << "Finished calculation!" << std::endl;
}
