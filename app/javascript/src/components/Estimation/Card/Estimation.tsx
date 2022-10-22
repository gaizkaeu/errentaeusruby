import { Card, Text } from '@nextui-org/react'
import { useGetEstimationByIdQuery } from '../../../storage/api'
import EstimationCard from './EstimationCard'

const EstimationWrapper = (props: { estimationId: string }, { ...rest }) => {
    const { data, isLoading, isError } = useGetEstimationByIdQuery(props.estimationId);
        return isLoading ? <EstimationCardSkeleton/> : (
        <EstimationCard estimation={data!} {...rest}/>
    )

}

const EstimationCardSkeleton = () => {
    return (
        <Card variant="flat">
            <Card.Body>
                <Text b>Estimación</Text>
                <div className="flex justify-between gap-5 mt-3 items-center animate-pulse">
                    <div>
                        <div className="h-2.5 bg-gray-300 rounded-full w-72 mb-2.5"></div>
                        <div className="w-42 h-2 bg-gray-200 rounded-full "></div>
                        <div className="w-42 h-2 bg-gray-200 rounded-full "></div>
                    </div>
                    <div className="h-2.5 bg-gray-300 rounded-full w-16"></div>
                </div>
                <div className="flex gap-5 mt-5 items-center animate-pulse">
                    <div className="h-8 bg-gray-300 rounded-xl w-24"></div>
                    <div className="h-8 bg-gray-300 rounded-xl w-24"></div>
                </div>
            </Card.Body>
        </Card>
    )
}

export default EstimationWrapper
