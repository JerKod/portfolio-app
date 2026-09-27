// Le catalogue : chaque techno n'est définie qu'UNE SEULE FOIS ici,
// avec son icône et son nom d'affichage. C'est ce qu'on appelle un
// "dictionnaire" (ou "objet") : chaque clé (ex: "kubernetes") donne
// accès à une valeur (ici, { label, icon }).
export const technologies = {
  astro: { label: "Astro", icon: "logos:astro-icon" },
  kubernetes: { label: "Kubernetes", icon: "logos:kubernetes" },
  k3s: { label: "K3S", icon: "logos:kubernetes" },
  terraform: { label: "Terraform", icon: "logos:terraform-icon" },
  ansible: { label: "Ansible", icon: "logos:ansible" },
  docker: { label: "Docker", icon: "logos:docker-icon" },
  fastapi: { label: "FastAPI", icon: "logos:fastapi-icon" },
  mongodb: { label: "MongoDB", icon: "logos:mongodb-icon" },
  grafana: { label: "Grafana", icon: "logos:grafana" },
  jenkins: { label: "Jenkins", icon: "logos:jenkins" },
  valkey: { label: "Valkey", icon: "logos:valkey-icon" },
  vault: { label: "Vault", icon: "logos:vault-icon" },
  argocd: { label: "Argo CD", icon: "logos:argo-icon" },
  python: { label: "Python", icon: "logos:python" },
  git: { label: "Git", icon: "logos:git-icon" },
  bash: { label: "Bash", icon: "logos:bash-icon" },
  postgresql: { label: "PostgreSQL", icon: "logos:postgresql" },
  githubactions: { label: "GitHub Actions", icon: "logos:github-actions" },
  apachehttp: { label: "Apache HTTP", icon: "logos:apache-http" },
  helm: { label: "Helm", icon: "logos:helm" },
  airflow: { label: "Airflow", icon: "logos:airflow-icon" },
  oraclecloud: { label: "Oracle Cloud", icon: "logos:oracle" },
  prometheus: { label: "Prometheus", icon: "logos:prometheus" },
  tailwind: { label: "Tailwind CSS", icon: "logos:tailwindcss-icon" },
  zabbix: { label: "Zabbix", icon: "logos:zabbix" }
} as const;

// Type TypeScript généré automatiquement à partir des clés ci-dessus :
// il empêchera d'écrire un id qui n'existe pas dans le catalogue
// (une faute de frappe sera détectée avant même de recharger la page)
export type TechId = keyof typeof technologies;

// Petite fonction utilitaire : transforme une liste d'identifiants
// (ex: ["kubernetes", "terraform"]) en liste d'objets complets
// (avec label et icon), en piochant dans le catalogue ci-dessus.
export function resolveTechs(ids: TechId[]) {
  return ids.map((id) => technologies[id]);
}
