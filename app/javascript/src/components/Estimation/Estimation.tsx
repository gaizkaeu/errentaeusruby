import React from 'react'
import { Button, Card, Loading, Text } from '@nextui-org/react'
import { useNavigate } from 'react-router-dom'
import { ArrowIcon } from '../Icons/ArrowIcon'
import { useGetEstimationByIdQuery } from '../../storage/api'
import EstimationCard from './EstimationCard'

const EstimationWrapper = (props: { estimationId: string }, {...rest}) => {
    const {data, isLoading} = useGetEstimationByIdQuery(props.estimationId);
    return isLoading ?  <Loading type="points" /> : (
            <EstimationCard estimation={data} {...rest}></EstimationCard>
        )
    
}

export default EstimationWrapper
