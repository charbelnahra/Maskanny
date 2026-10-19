import { redirect } from "next/navigation";
import { createCookieClient } from "@/src/lib/supabase/cookie-client";
import type { Metadata } from "next";

export const metadata: Metadata = {
  title: "Maskanny | Owner Dashboard",
};

export const dynamic = "force-dynamic";

export default async function DashboardLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createCookieClient();
  const {
    data: { user },
    error: authError,
  } = await supabase.auth.getUser();
  if (authError || !user) redirect("/sign-in");
  return <section>{children}</section>;
}
