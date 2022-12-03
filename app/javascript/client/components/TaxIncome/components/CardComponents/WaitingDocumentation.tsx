import { Documents } from "../../../Document/Document";
import { TaxIncome } from "../../../../storage/models/TaxIncome";

const DocumentationUpload = (props: { taxIncome: TaxIncome }) => {
  const { taxIncome } = props;

  return <Documents taxIncomeId={taxIncome.id} />;
};

export default DocumentationUpload;
