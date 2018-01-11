#include "\tc\CLib\addons\CLib\ModuleMacros.hpp"

class CfgCLibModules {
    class BBR {
        path = "\bbr\BBR\addons\BBR"; // TODO add Simplifyed Macro for this
        dependency[] = {"CLib"};
        MODULE(Common) {
            FNC(init);
        };
        MODULE(GearSpawn) {
            dependency[] = {"BBR/Common"};
            FNC(clientInit);
            FNC(createKit);
            FNC(getWeaponHolder);
            FNC(init);
            FNC(removeKit);
            FNC(serverInit);
        };
        MODULE(SimpleInteraction) {
            FNC(checkHouse);
            FNC(checkWeaponHolder);
            FNC(clientInit);
            FNC(openDoor);
            FNC(takeItem);
        };
    };
};
