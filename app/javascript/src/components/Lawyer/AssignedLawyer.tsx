import { Card, Text } from "@nextui-org/react";
import LawyerAvatar, { NoLawyerAvatar } from "./Lawyer";
import { useGetLawyerByIdQuery } from "../../storage/api";
import { useTranslation } from "react-i18next";

const AssignedLawyerCard = (props: { lawyerId: string }) => {
  const { t } = useTranslation();
  const { data, isLoading, isError } = useGetLawyerByIdQuery(props.lawyerId);
  return (
    <Card variant="flat" role="dialog">
      <Card.Body>
        <Text b>{t("lawyers.assignedLawyer")}</Text>
        <div className="mt-3">
          {isLoading ? (
            <LawyerSkeleton />
          ) : !data || isError ? (
            <NoLawyerAvatar />
          ) : (
            <LawyerAvatar size="md" lawyer={data!} />
          )}
        </div>
      </Card.Body>
    </Card>
  );
};

export const LawyerSkeleton = () => {
  return (
    <div className="flex items-center space-x-3 animate-pulse">
      <svg
        className="w-14 h-14 text-gray-200 "
        aria-hidden="true"
        fill="currentColor"
        viewBox="0 0 20 20"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          fillRule="evenodd"
          d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-6-3a2 2 0 11-4 0 2 2 0 014 0zm-2 4a5 5 0 00-4.546 2.916A5.986 5.986 0 0010 16a5.986 5.986 0 004.546-2.084A5 5 0 0010 11z"
          clipRule="evenodd"
        ></path>
      </svg>
      <div>
        <div className="h-2.5 bg-gray-200 rounded-full  w-32 mb-2"></div>
        <div className="w-48 h-2 bg-gray-200 rounded-full "></div>
      </div>
    </div>
  );
};

export const AssignedLawyerSimple = (props: {
  lawyerId: string;
  size: "xs" | "sm" | "md";
}) => {
  const { data, isLoading, isError } = useGetLawyerByIdQuery(props.lawyerId);
  return isLoading ? (
    <LawyerSkeleton />
  ) : !data || isError ? (
    <NoLawyerAvatar />
  ) : (
    <LawyerAvatar size={props.size} lawyer={data!} />
  );
};

export default AssignedLawyerCard;
