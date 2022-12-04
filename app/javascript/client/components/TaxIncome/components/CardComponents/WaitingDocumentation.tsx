import { Documents } from "../../../Document/Document";
import { TaxIncome } from "../../../../storage/models/TaxIncome";

const DocumentationUpload = (props: {
  taxIncome: TaxIncome;
  lawyer: boolean;
}) => {
  return <Documents taxIncomeId={props.taxIncome.id} lawyer={props.lawyer} />;
};

export default DocumentationUpload;
