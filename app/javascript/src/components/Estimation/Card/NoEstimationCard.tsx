import { Button, Card, Text } from '@nextui-org/react'
import { useNavigate } from 'react-router-dom'
import { ArrowIcon } from '../../Icons/ArrowIcon'

const NoEstimationCard = () => {
    const navigate = useNavigate()
    return (
        <Card variant="flat">
            <Card.Body>
                <Text b>No tenemos ninguna estimación.</Text>
                <Text>Utilizamos las estimaciones para hacer las cosas más sencillas y claras.</Text>
                <Button
                    rounded
                    className="mt-3"
                    size={'lg'}
                    auto
                    onPress={() => navigate('/calculator')}
                    iconRight={<ArrowIcon />}
                >
                    Calcula tu precio
                </Button>
            </Card.Body>
        </Card>
    )
}

export default NoEstimationCard
