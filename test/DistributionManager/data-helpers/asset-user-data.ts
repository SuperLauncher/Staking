import { BigNumber } from "ethers";
import { AaveDistributionManager } from "../../../types/AaveDistributionManager";
import { SvLaunch } from "../../../types/SvLaunch";
//import { AaveIncentivesController } from "../../../types/AaveIncentivesController";
//import { StakedAaveV2 } from "../../../types/StakedAaveV2";

export type UserStakeInput = {
  underlyingAsset: string;
  stakedByUser: string;
  totalStaked: string;
};

export type UserPositionUpdate = UserStakeInput & {
  user: string;
};
export async function getUserIndex(
  distributionManager:
    | AaveDistributionManager
    //| AaveIncentivesController
    | SvLaunch,
   // | StakedAaveV2,
  user: string,
  asset: string
): Promise<BigNumber> {
  return await distributionManager.getUserAssetData(user, asset);
}
