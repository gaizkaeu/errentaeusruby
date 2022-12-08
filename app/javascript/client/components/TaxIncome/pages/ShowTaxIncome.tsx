import { Fragment, useEffect, useState } from "react";
import {
  Collapse,
  Container,
  Modal,
  Spacer,
  Switch,
  Text,
} from "@nextui-org/react";
import { Navigate, useNavigate, useParams } from "react-router-dom";
import AssignedLawyerCard from "../../Lawyer/AssignedLawyer";
import { useGetTaxIncomeByIdQuery } from "../../../storage/api";
import { EstimationWrapper } from "../../Estimation/EstimationCard";
import { useAuth } from "../../../hooks/authHook";
import { TaxIncomeAdminPanel } from "../LawyerComponents/TaxIncomeAdminPanel";
import { CpuChipIcon } from "@heroicons/react/24/outline";
import { TaxIncomeDeleteComponent } from "../components/Actions/DeleteTaxIncome";
import { Stepper } from "../components/Shared/Stepper";
import { TaxIncome } from "../../../storage/models/TaxIncome";
import { Documents } from "../../Document/Document";
import { t } from "i18next";
import { TaxIncomeCard } from "../components/Cards";

export const ShowTaxIncomeSkeleton = () => {
  return (
    <div className="flex flex-col gap-5 p-2 mx-auto select-none sm:p-4 sm:h-64 rounded-2xl sm:flex-row ">
      <div className="flex flex-col flex-1 gap-5 sm:p-2">
        <div className="flex flex-col flex-1 gap-3">
          <div className="w-full bg-gray-400 animate-pulse h-14 rounded-2xl"></div>
          <div className="w-full h-3 bg-gray-400 animate-pulse rounded-2xl"></div>
          <div className="w-full h-3 bg-gray-400 animate-pulse rounded-2xl"></div>
          <div className="w-full h-3 bg-gray-400 animate-pulse rounded-2xl"></div>
          <div className="w-full h-3 bg-gray-400 animate-pulse rounded-2xl"></div>
          <div className="w-full h-3 bg-gray-400 animate-pulse rounded-2xl"></div>
          <div className="w-full h-3 bg-gray-400 animate-pulse rounded-2xl"></div>
          <div className="w-full h-3 bg-gray-400 animate-pulse rounded-2xl"></div>
        </div>
        <div className="flex gap-3 mt-auto">
          <div className="w-20 h-8 bg-gray-400 rounded-full animate-pulse"></div>
          <div className="w-20 h-8 bg-gray-400 rounded-full animate-pulse"></div>
          <div className="w-20 h-8 ml-auto bg-gray-400 rounded-full animate-pulse"></div>
        </div>
      </div>
      <div className="bg-gray-400 h-64 sm:h-full sm:w-72 rounded-xl animate-pulse"></div>
    </div>
  );
};

const ShowTaxIncome = () => {
  const { tax_income_id, page } = useParams();
  const { currentUser } = useAuth();
  const [refetch, setRefetch] = useState(true);
  const { currentData, isLoading, isError, error } = useGetTaxIncomeByIdQuery(
    tax_income_id ?? "0",
    {
      pollingInterval: 3000,
      skip: !refetch,
    }
  );
  const nav = useNavigate();

  useEffect(() => {
    if (!page && currentData) {
      nav(`/mytaxincome/${tax_income_id}/${currentData?.state}`, {
        replace: true,
      });
    }
  });

  const ErrorModal = () => (
    <Modal
      closeButton
      blur
      aria-labelledby="modal-title"
      open={isError || !currentData}
    >
      <Modal.Header>
        <Text id="modal-title" size={18}>
          Error
        </Text>
      </Modal.Header>
      <Modal.Body>
        <Text b>No puedes acceder</Text>
        <Text>{JSON.stringify(error?.data)}</Text>
        <div className="flex items-center gap-4">
          <Text>¿Reintentar?</Text>
          <Switch
            checked={refetch}
            size="xl"
            onChange={() => setRefetch((r) => !r)}
            color="secondary"
            icon={<CpuChipIcon />}
          />
        </div>
      </Modal.Body>
    </Modal>
  );

  return (
    <div className="px-4 mx-auto max-w-7xl sm:px-6 lg:px-8">
      {!isError && currentData && refetch && page ? (
        <>
          <div className="flex flex-wrap items-center">
            <div className="flex-1">
              <Stepper />
            </div>
            <TaxIncomeDeleteComponent taxIncomeId={currentData.id} />
          </div>
          {currentUser?.account_type === "lawyer" ? (
            <>
              <Spacer y={2} />
              <LawyerView data={currentData} page={page} />
            </>
          ) : (
            <UserView data={currentData} page={page} />
          )}
        </>
      ) : isLoading ? (
        <ShowTaxIncomeSkeleton />
      ) : (
        <ErrorModal />
      )}
    </div>
  );
};

const UserView = (props: { data: TaxIncome; page: string }) => {
  const navCurrentState = () => (
    <Navigate
      to={`/mytaxincome/${props.data.id}/${props.data.state}`}
      replace={true}
    ></Navigate>
  );

  return (
    <div className="md:mt-10 p-3">
      <Text h3 b>
        {t(`taxincome.statuses.${props.data.state}`)}
      </Text>
      <div className="flex flex-wrap gap-10">
        <div className="flex-1">
          <TaxIncomeCard
            lawyer={false}
            taxIncome={props.data}
            renderCard={props.page}
            navCurrentState={navCurrentState()}
          />
        </div>
        <div className="w-full lg:w-auto">
          {props.data.lawyer && (
            <AssignedLawyerCard lawyerId={props.data.lawyer} />
          )}
          <Spacer />
          <EstimationWrapper estimationId={props.data.estimation} />
        </div>
      </div>
    </div>
  );
};

const LawyerView = (props: { data: TaxIncome; page: string }) => (
  <>
    <Collapse title="Vista de Usuario" subtitle="Solo ver">
      <Container css={{ pointerEvents: "none" }}>
        <UserView data={props.data} page={props.page} />
      </Container>
    </Collapse>
    <Collapse title="Documents">
      <Documents lawyer={true} taxIncomeId={props.data.id} />
    </Collapse>
    <Collapse title="Panel de administrador">
      <TaxIncomeAdminPanel taxIncome={props.data} />
    </Collapse>
  </>
);

export default ShowTaxIncome;
