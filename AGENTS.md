# AGENTS.md

# Bolt Workspace
## AI Development Guide & Engineering Standards

---

# Purpose

This document defines the development standards, engineering principles, architecture rules, coding standards, and AI operating procedures for Bolt Workspace.

It is intended for AI coding assistants (Claude, ChatGPT Codex, GitHub Copilot, Cursor, and future AI development tools) as well as human developers contributing to the project.

This document must always be read before implementing any feature.

---

# Project Overview

Bolt Workspace is an enterprise-grade Internal Project Management & Collaboration Platform developed exclusively for **Bolt Technology Solutions Sdn. Bhd.**

The application centralizes:

- Project Management
- Task Management
- Timeline Management
- Collaboration
- Documentation
- Executive Reporting
- Google Workspace Integration

The objective is to replace spreadsheets, WhatsApp conversations, emails and manual tracking with one centralized system.

---

# Project Scope

Bolt Workspace Version 1 focuses exclusively on internal project management.

The following modules are included.

## Authentication

- Google Workspace Login
- Role-Based Access Control (RBAC)

## Dashboard

- CEO Dashboard
- Staff Dashboard
- KPI Cards
- Recent Activity
- Quick Actions

## Project Management

- Projects
- Timeline
- Milestones
- Project Health
- Risks & Issues
- Meeting Notes

## Task Management

- Tasks
- Assignments
- Priorities
- Due Dates
- Progress Tracking

## Collaboration

- Comments
- Activity Log
- Notifications

## Google Workspace Integration

- Google Drive
- Google Calendar (Read Only)
- Gmail (Open Draft Only)

## Reporting

- Executive Weekly Report
- Project Progress Report
- Milestone Report
- Project Closure Report

---

# Out of Scope

The following systems are NOT part of Version 1.

- CRM
- HR Management
- Payroll
- Procurement
- Finance
- Inventory
- Asset Management

AI must never introduce these modules unless explicitly approved.

---

# Source of Truth

The following documents are the official project references.

1. Project Charter & Vision
2. Functional Requirements Specification
3. UI / UX Specification
4. Technical Design Specification
5. Development Standards
6. Deployment, Operations & Support Guide
7. Project Execution Plan

If generated code conflicts with documentation,

**Documentation always wins.**

Never invent requirements.

Never guess business rules.

Always ask for clarification.

---

# Technology Stack

## Frontend

- Next.js 16
- React
- TypeScript

## Styling

- Tailwind CSS

## Backend

- Supabase PostgreSQL

## Authentication

- Google Workspace OAuth

## Hosting

- Cloudflare Pages

## File Storage

- Google Drive

## Calendar

- Google Calendar API (Read Only)

## Source Control

- GitHub

---

# Engineering Principles

Every implementation must follow these principles.

- Documentation First
- Security by Design
- Clean Architecture
- Modular Design
- Reusable Components
- Mobile Responsive
- Simplicity over Complexity
- Enterprise UI Standards
- Low Maintenance
- Performance First

---

# Coding Standards

Always

- Use TypeScript
- Use Functional Components
- Use reusable UI components
- Keep functions small
- Separate UI from business logic
- Separate business logic from database access
- Use strong typing
- Use descriptive variable names
- Follow consistent naming conventions

Never

- Duplicate code
- Hardcode values
- Hardcode URLs
- Hardcode roles
- Hardcode status values
- Mix UI and API logic
- Mix UI and database logic
- Ignore TypeScript errors

---

# Folder Structure

The repository should follow this structure.

```
app/
components/
features/
hooks/
lib/
services/
types/
utils/
docs/
public/
```

Avoid unnecessary folders.

---

# UI Development Rules

Every screen must be:

- Responsive
- Desktop friendly
- Tablet friendly
- Mobile friendly

Maintain consistent

- Navigation
- Buttons
- Cards
- Forms
- Tables
- Typography
- Icons
- Colors

Never redesign approved UI without approval.

---

# Database Rules

Database Platform

Supabase PostgreSQL

Rules

- UUID Primary Keys
- Foreign Key Relationships
- Soft Delete where applicable
- Audit Logging
- No schema changes without approval
- No column removal
- No table renaming

---

# Authentication Rules

Authentication uses Google Workspace only.

Requirements

- Google OAuth
- Company email only
- RBAC
- Secure session management

Never create local username/password authentication.

---

# Google Workspace Rules

## Google Drive

- Store project document references.
- Use Drive folder links.
- Do not store documents locally.

## Google Calendar

- Read Only
- Never create events
- Never update events
- Never delete events

## Gmail

- Open Gmail Draft
- Pre-fill recipient
- Pre-fill subject
- Pre-fill body

Never automatically send emails.

---

# Reporting Rules

Reports must use actual database information.

AI may

- Summarize
- Highlight risks
- Identify blockers

AI must never

- Invent statistics
- Invent project status
- Invent completion percentages

Every report must be reproducible from stored project data.

---

# Security Rules

Always

- Validate permissions
- Validate user input
- Protect secrets
- Use environment variables
- Validate server-side

Never

- Expose API Keys
- Expose Secrets
- Trust client-side validation

---

# Git Standards

Branch Naming

```
feature/authentication
feature/dashboard
feature/projects
feature/tasks
feature/reports
bugfix/login
```

Commit Examples

```
feat:
fix:
refactor:
docs:
style:
```

Never commit directly to production without review.

---

# Development Workflow

```
Requirements

↓

Architecture Review

↓

Implementation

↓

Testing

↓

Code Review

↓

GitHub Commit

↓

Cloudflare Deployment

↓

Production
```

---

# AI Behaviour Rules

Before implementing anything,

AI must

1. Read the requirements.
2. Review the related documentation.
3. Understand business rules.
4. Review existing components.
5. Reuse existing code where possible.
6. Identify impacted files.
7. Explain the implementation approach.
8. Then write code.

If requirements are unclear,

STOP.

Ask for clarification.

Never assume.

---

# Definition of Done

A feature is complete only if

- Functional requirements implemented
- UI matches specification
- Responsive
- No TypeScript errors
- No ESLint errors
- Tested
- Ready for review

---

# Version 1 Scope Protection

AI must not introduce new business modules.

Examples

❌ HR

❌ Payroll

❌ Finance

❌ CRM

❌ Procurement

❌ Inventory

❌ Asset Management

Future enhancements belong to future releases.

---

# AI Response Format

Whenever implementing a feature, AI should respond in the following order.

## 1. Requirement Understanding

Summarize the requested feature and confirm understanding before implementation.

## 2. Impact Analysis

Identify:

- Modules affected
- Components affected
- Database changes (if any)
- API changes (if any)
- UI changes (if any)

## 3. Implementation Plan

Provide a step-by-step implementation approach before writing code.

## 4. Code Implementation

Generate clean, modular, production-ready code.

Reuse existing components wherever possible.

## 5. Summary

Explain what was implemented.

List:

- New files
- Updated files
- New components
- New APIs
- Database changes

## 6. Validation

Confirm:

- TypeScript passes
- ESLint passes
- Responsive layout maintained
- Existing functionality not broken

## 7. Assumptions

Clearly state any assumptions made.

If assumptions affect business rules,

STOP and request clarification instead of guessing.

---

# AI Mission Statement

Your responsibility is not simply to generate code.

Your responsibility is to build a maintainable, scalable, secure and enterprise-grade internal project management platform that strictly follows the approved project documentation.

Quality is more important than speed.

Documentation is more important than assumptions.

Consistency is more important than shortcuts.

When uncertain,

**Always ask before changing the architecture, business rules or user experience.**