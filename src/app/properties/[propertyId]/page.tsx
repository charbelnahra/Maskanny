import PropertyDetails from "@/src/features/properties/presentation/components/PropertyDetails";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Maskanny | Property Details",
};

export default async function PropertyDetailsPage({
  params,
}: {
  params: Promise<{ propertyId: string }>;
}) {
  const { propertyId } = await params;
  return <PropertyDetails propertyId={propertyId} />;
}
