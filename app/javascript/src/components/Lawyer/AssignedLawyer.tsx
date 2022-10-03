import { Card, Loading, Text } from "@nextui-org/react";
import LawyerAvatar from "./Lawyer";
import { useGetLawyerByIdQuery } from "../../storage/api";

const AssignedLawyerCard = (props: { lawyerId: string }) => {
    const {data, isLoading, isError} = useGetLawyerByIdQuery(props.lawyerId);
    return isLoading || !data || isError ?  <Loading type="points" /> : (
        <Card variant="flat">
            <Card.Body>
                <Text b>Tu asesor fiscal</Text>
                 <LawyerAvatar lawyer={data!} /> 
            </Card.Body>
        </Card>
    )
}

export const AssignedLawyerSimple = (props: { lawyerId: string }) => {
    const {data, isLoading, isError} = useGetLawyerByIdQuery(props.lawyerId);
    return isLoading || !data || isError ?  <Loading type="points" /> : (
        <LawyerAvatar lawyer={data!} /> 
    )
}

export default AssignedLawyerCard;