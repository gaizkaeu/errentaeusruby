import { Text } from "@nextui-org/react";
import { Fragment } from "react";
import { Documents } from "../../../Document/Document";
import { useTranslation } from "react-i18next";
import { TaxIncome } from "../../../../storage/models/TaxIncome";

const DocumentationUpload = (props: { taxIncome: TaxIncome }) => {
  const { t } = useTranslation();
  const { taxIncome } = props;

  return (
    <Fragment>
      <Text h3>{t("documentation.title")}</Text>
      <Documents taxIncomeId={taxIncome.id} />
    </Fragment>
  );
};

export default DocumentationUpload;
