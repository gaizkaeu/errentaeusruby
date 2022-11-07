import { Card, Spacer, Text } from "@nextui-org/react"
import NewAppointmentForm from "../../../Appointment/NewAppointment";
import { TaxIncome } from "../../../../storage/types";
import { useGetDocumentsOfTaxIncomeQuery } from "../../../../storage/api";
import { Fragment } from "react";
import { DocumentComponent } from "../../../Document/Document";

const DocumentationUpload = (props: { taxIncome: TaxIncome }) => {
    const { taxIncome } = props;
    const {currentData, isLoading, isError} = useGetDocumentsOfTaxIncomeQuery(taxIncome.id)
    return (
        <Fragment>
            <Text h3>Documentación</Text>
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