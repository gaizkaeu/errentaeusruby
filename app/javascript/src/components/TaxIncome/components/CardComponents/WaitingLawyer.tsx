import { Loading,Text } from "@nextui-org/react"

const WaitingLawyer = () => {
    return (
       <div className="grid grid-cols-1 gap-3 place-content-center text-center">
            <Text>Te estamos asignando un abogado</Text>
            <Loading/>
       </div> 
    )
}

export default WaitingLawyer;