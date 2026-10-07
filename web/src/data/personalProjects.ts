import type { TechId } from "./technologies";

export interface PersonalProject {
  id: string;
  name: string;
  startDate: string;
  endDate: string | null;
  tagline: string;
  highlights: string[];
  techIds: TechId[];
  caseStudyUrl?: string;
  repoUrl?: string;
}

export const personalProjects: PersonalProject[] = [
  {
    id: "portfolio-sre-lab",
    name: "Portfolio & SRE Lab",
    startDate: "2026-09",
    endDate: null,
    tagline: "Self-hosted infrastructure project: designed as both a portfolio and a hands-on SRE lab.",
    highlights: [
      "Built the application (Astro frontend, FastAPI backend) in a fully containerized dev environment (VS Code Dev Containers), with live uptime, SLO, and request-rate metrics served by the API itself.",
      "Designing the target infrastructure as code: a k3s cluster on Oracle Cloud's free tier, provisioned with Terraform and Ansible, deployed via GitOps (Argo CD) from GitHub Actions, with Prometheus/Grafana observability — in progress, tracked openly on the project page.",
    ],
    techIds: ["astro", "python", "fastapi", "docker"],
    caseStudyUrl: "/projects/portfolio/",
  },
];

export function formatProjectPeriod(p: PersonalProject): string {
  return `${p.startDate} — ${p.endDate ?? "Present"}`;
}
