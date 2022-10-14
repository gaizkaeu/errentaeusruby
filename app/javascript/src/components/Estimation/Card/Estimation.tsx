import { Loading } from '@nextui-org/react'
import { useGetEstimationByIdQuery } from '../../../storage/api'
import EstimationCard from './EstimationCard'

const EstimationWrapper = (props: { estimationId: string }, {...rest}) => {
    const {data, isLoading} = useGetEstimationByIdQuery(props.estimationId);
    return isLoading ?  <Loading type="points" /> : (
            <EstimationCard estimation={data!} {...rest}></EstimationCard>
        )
    
}

export default EstimationWrapper
