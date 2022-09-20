import React from 'react'
import { Button, Card, Text } from '@nextui-org/react'
import { useNavigate } from 'react-router-dom'
import { Estimation } from '../../storage/estimationSlice'
import { ArrowIcon } from '../Icons/ArrowIcon'

const EstimationCard = (props: { estimation: Estimation | undefined }) => {
    const navigate = useNavigate()
    const { estimation } = props
    return (
        <Card isHoverable variant="bordered" css={{ mw: '400px' }}>
            <Card.Header>
                <Text b size="$lg">
                    Añadir tu estimación.
                </Text>
            </Card.Header>
            {estimation ? (
                <Card.Body>
                    <Text size="$xl">
                        Tu estimación de{' '}
                        <span className="text-green-600 font-bold">
                            {estimation.price} €.
                        </span>
                    </Text>
                    <Button
                        rounded
                        bordered
                        flat
                        className="px-6 py-4 mt-3"
                        color="error"
                        size={'lg'}
                        auto
                    >
                        Revisar
                    </Button>
                </Card.Body>
            ) : (
                <Card.Body>
                    <Button
                        rounded
                        className=""
                        color="gradient"
                        size={'lg'}
                        auto
                        onPress={() => navigate('/calculator')}
                        iconRight={<ArrowIcon />}
                    >
                        Calcula tu precio
                    </Button>
                </Card.Body>
            )}
        </Card>
    )
}

export default EstimationCard
