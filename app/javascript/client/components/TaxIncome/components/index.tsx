import { Loading } from "@nextui-org/react";

import { useGetTaxIncomesQuery } from "../../../storage/api";
import { SearchBar } from "../../Search";
import { TaxIncomeCardMin } from "./Cards";

export const TaxIncomeCardMinList = (props: { searchBar: boolean }) => {
  const { currentData, isError, isLoading } = useGetTaxIncomesQuery();

  return (
    <div className="grid grid-cols-1 gap-4">
      {props.searchBar && (
        <div className="">
          <SearchBar />
        </div>
      )}
      {isLoading || isError || !currentData ? (
        <Loading type="points" />
      ) : (
        currentData.map((v, ind) => {
          return <TaxIncomeCardMin taxIncome={v} key={ind} />;
        })
      )}
    </div>
  );
};
