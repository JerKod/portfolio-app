import type { TechId } from "./technologies";

// La forme de chaque expérience, pensée comme un futur document MongoDB.
// "startDate"/"endDate" en vraies dates (endDate absente = poste actuel),
// plutôt qu'un texte "2023 — Aujourd'hui" écrit à la main.
export interface Experience {
  id: string;              // deviendra l'_id MongoDB plus tard
  startDate: string;        // format "AAAA-MM", simple à trier et à lire
  endDate: string | null;   // null = poste toujours en cours
  title: string;
  org: string;
  scope: string;
  highlights: string[];
  techIds: TechId[];        // référence au catalogue, comme convenu avant
  caseStudyUrl?: string;
}

export const experiences: Experience[] = [
  {
    id: "transactis-devops-platform-engineer",
    startDate: "2025-01",
    endDate: null,
    title: "DevOps Platform Engineer",
    org: "Transactis",
    scope: "Platform team of 7 engineers, working in Scrum; self-service infrastructure for internal teams on SG Cloud (private cloud).",
    highlights: [
      "Self-service Jenkins workers pipeline: secure, multi-AZ workers provisioned in under 15 minutes, with a fleet of 15 workers rebuilt on a regular rolling-update basis.",
      "Automated security compliance with HashiCorp Vault and observability with Grafana Alloy for log and metrics collection, across all self-service pipelines.",
      "Self-service MongoDB ReplicaSet pipeline (Community and Enterprise): secure multi-AZ deployment (SELinux, TLS, keyfile authentication) in 20 minutes — half the deployment time of the previous pipeline — with rolling mongod upgrades and progressive node rebuilds.",
      "MongoDB Ops Manager deployment solution: secure, multi-AZ, load-balanced setup in 20 minutes, replacing a previously semi-manual process.",
      "Self-service Valkey Cluster pipeline: secure multi-AZ deployment with rolling upgrades and progressive node rebuilds.",
    ],
    techIds: ["jenkins", "terraform", "ansible", "vault", "mongodb", "valkey", "grafana"],
  },
  {
    id: "transactis-infrastructure-technical-referent",
    startDate: "2023-01",
    endDate: "2025-01",
    title: "Infrastructure Technical Referent",
    org: "Transactis",
    scope: "Technical referent for a team of 8 production engineers, across a multi-platform banking environment: SG Cloud, Docker, Kubernetes, Linux, AIX, Windows Server.",
    highlights: [
      "Ensured strict compliance with security standards and architectural guidelines across a complex multi-platform environment.",
      "Engineered CI/CD and orchestration pipelines with Terraform, Ansible/AWX, Jenkins, Python, Shell and Airflow.",
      "Maintaining high availability for core banking applications while managing on-call rotations.",
      "Established best practices around Git, automation scripts, and monitoring; led technical interviews for external consultants.",
    ],
    techIds: ["terraform", "ansible", "jenkins", "python", "airflow", "kubernetes", "docker", "git"],
  },
  {
    id: "sopra-steria-team-leader",
    startDate: "2021-01",
    endDate: "2023-01",
    title: "Team Leader",
    org: "Sopra Steria",
    scope: "Led a group of 5 production engineers at SG (Société Générale): 2 direct reports, plus cross-team coordination with 3 engineers in other teams.",
    highlights: [
      "Acted as primary technical reference, providing level-3 support and ensuring service continuity for the team.",
    ],
    techIds: [],
  },
  {
    id: "sopra-steria-it-production-engineer",
    startDate: "2019-01",
    endDate: "2021-01",
    title: "IT Production Engineer",
    org: "Sopra Steria",
    scope: "Level-3 production support for critical banking applications across RHEL, AIX, and Windows Server.",
    highlights: [
      "Maintained high availability of critical banking applications; resolved incidents and executed changes in 24/7 on-call rotations using Control-M, Zabbix, and Grafana.",
      "Wrote operational procedures and runbooks for teams in Poland and India.",
      "Supported application lifecycles across WebLogic, JBoss, Tomcat, Apache HTTP Server, Oracle Database and IBM Websphere MQ using Shell and Python.",
    ],
    techIds: ["zabbix", "grafana", "python", "bash"],
  },
];

// Le plus simple possible pour l'instant : affiche les dates brutes
export function formatPeriod(exp: Experience): string {
  return `${exp.startDate} — ${exp.endDate ?? "Present"}`;
}
