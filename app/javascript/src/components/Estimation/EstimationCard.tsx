import React from 'react'
import { Button, Card, Text } from '@nextui-org/react'
import { useNavigate } from 'react-router-dom'
import { Estimation } from '../../storage/estimationSlice'
import { ArrowIcon } from '../Icons/ArrowIcon'

const EstimationCard = (props: { estimation: Estimation | undefined, deletable?: boolean }) => {
    const navigate = useNavigate()
    const { estimation, deletable } = props
    return (
        <Card isHoverable>
            {estimation ? (
                <Card.Body>
                    <Text size="$xl">
                        Tu estimación de {' '}
                        <span className="text-green-600 font-bold">
                            {estimation.price} €.
                        </span>
                    </Text>
                    <Text size="$sm">Nota: Esta información será visible para nuestros asesores</Text>
                    <div className="flex w-full gap-7">
                        <Button
                            rounded
                            bordered
                            flat
                            className="px-6 py-4 mt-3 flex-1"
                            color="warning"
                            size={'lg'}
                            auto
                        >
                            Revisar
                        </Button>
                        {deletable && (
                            <Button
                                rounded
                                bordered
                                flat
                                className="px-6 py-4 mt-3 flex-1"
                                color="error"
                                size={'lg'}
                                auto
                            >
                                Eliminar
                            </Button>)}
                    </div>
                </Card.Body>
            ) : (
                <Card.Body>
                    <Text>No tenemos ninguna estimación... Puedes continuar o calcularla.</Text>
                    <Button
                        rounded
                        className="mt-3"
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
