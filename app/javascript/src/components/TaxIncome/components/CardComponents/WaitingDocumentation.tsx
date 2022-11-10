import { Card, Spacer, Text } from "@nextui-org/react"
import NewAppointmentForm from "../../../Appointment/NewAppointment";
import { TaxIncome } from "../../../../storage/types";
import { useGetDocumentsOfTaxIncomeQuery } from "../../../../storage/api";
import { Fragment } from "react";
import { DocumentComponent } from "../../../Document/Document";
import { useTranslation } from "react-i18next";

const DocumentationUpload = (props: { taxIncome: TaxIncome }) => {
    const { t, i18n } = useTranslation();
    const { taxIncome } = props;
    const {currentData, isLoading, isError} = useGetDocumentsOfTaxIncomeQuery(taxIncome.id, {
        pollingInterval: 3000
    })
    return (
        <Fragment>
            <Text h3>{t('documentation.title')}</Text>
            {currentData && !isLoading && !isError && (
                <div className="grid grid-cols-1 gap-4">
                    {currentData.map((doc, index) => (
                        <DocumentComponent document={doc} key={index}/>
                    )
                )}
                </div>
            )}
        </Fragment>
    )
}

export default DocumentationUpload;