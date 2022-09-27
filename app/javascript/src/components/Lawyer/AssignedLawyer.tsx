import React from "react";
import { Card, Loading, Text } from "@nextui-org/react";
import LawyerAvatar from "./Lawyer";
import { useGetLawyerByIdQuery } from "../../storage/api";

const AssignedLawyer = (props: { lawyerId: string }) => {
    const {data, isLoading, isError} = useGetLawyerByIdQuery(props.lawyerId);
    return isLoading || !data || isError ?  <Loading type="points" /> : (
        <Card>
            <Card.Body>
                <Text b>Tu asesor fiscal</Text>
                 <LawyerAvatar lawyer={data!} /> 
            </Card.Body>
        </Card>
    )
}

export default AssignedLawyer;