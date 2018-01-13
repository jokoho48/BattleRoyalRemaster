#include "\tc\CLib\addons\CLib\ModuleMacros.hpp"

class CfgCLibModules {
    class BBR {
        path = "\bbr\BBR\addons\BBR"; // TODO add Simplifyed Macro for this
        dependency[] = {"CLib"};
        MODULE(Common) {
            FNC(arrayInArea);
            FNC(clientInitAreaBuildingSystem);
            FNC(getWeaponType);
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
        MODULE(Medical) {
            dependency[] = {"BBR/Common"};
            FNC(actionHeal);
            FNC(actionHelp);
            FNC(bloodEffect);
            FNC(clientInit);
            FNC(clientInitEffects);
            FNC(handleDamage);
            FNC(handlePP);
            FNC(init);
            FNC(setUnconscious);
        };
        MODULE(SimpleInteraction) {
            dependency[] = {"BBR/Common"};
            FNC(checkHouse);
            FNC(checkWeaponHolder);
            FNC(clientInit);
            FNC(clientInitLadderAction);
            FNC(evaluateAction);
            FNC(openDoor);
            FNC(takeItem);
        };
    };
};
