import { Button, Card, Text } from '@nextui-org/react'
import { useNavigate } from 'react-router-dom'
import { ArrowIcon } from '../../Icons/ArrowIcon'
import NoEstimationCard from './NoEstimationCard'
import { Estimation } from '../../../storage/types'

const EstimationCard = (props: { estimation: Estimation | undefined, deletable?: boolean }) => {
    const { estimation, deletable } = props
    return (
        <Card variant="flat">
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
                <NoEstimationCard/>
            )}
        </Card>
    )
}

export default EstimationCard